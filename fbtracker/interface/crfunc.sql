-- ----------------------------------------------------------------------------
-- FBtracker Interface
-- Copyright (c) 2010 Front Burner
-- Author Craig McKay <craig@frontburner.co.uk>
--
-- $Id: crtrig.sql 1302 2010-12-30 18:51:25Z craig $
-- ----------------------------------------------------------------------------


-- ----------------------------------------------------------------------------
-- fbtracker_generate_invoice copies changed clients from Kimai to Bamboo
-- CALL kimai.fbtracker_generate_invoice();
-- ----------------------------------------------------------------------------

DROP PROCEDURE IF EXISTS kimai.fbtracker_generate_invoice;

delimiter |

CREATE PROCEDURE kimai.fbtracker_generate_invoice()
READS SQL DATA
BEGIN

  DECLARE not_found INT DEFAULT 0;
  DECLARE curr_client_id INT;
  DECLARE total_hours FLOAT;
  DECLARE total_days FLOAT;
  DECLARE ratetype CHAR(1);
  DECLARE rate FLOAT;
  DECLARE line_quantity FLOAT;

  DECLARE get_time CURSOR FOR
    SELECT kp.pct_kndid,
      MIN(bc.ratetype) ratetype, MIN(bc.rate) rate,
      CEILING(SUM(kz.zef_time)/60/60) hours,
      CEILING(SUM(kz.zef_time)/60/60) /8 days
    FROM kimai_zef kz, kimai_pct_evt ke, kimai_pct kp, bamboo.bb_clients bc
    WHERE ke.evt_id = kz.zef_evtid
    AND kp.pct_id = ke.pct_id
    AND bc.id = kp.pct_kndid
    AND kz.zef_invoiceno IS NULL
    GROUP BY kp.pct_kndid;

  DECLARE CONTINUE HANDLER FOR NOT FOUND SET not_found = 1;

  -- update all kimai_zef lines zef_invoiceno to null where the matching invoice does not have an issuedate
  -- for each client with null zef_invoiceno lines
    -- sum all null zef_invoiceno lines by client and either create a new invoice or replace the Line 1 of existing invoice
    -- update each with the new invoiceno

  UPDATE kimai_zef kz
  SET zef_invoiceno = NULL
  WHERE EXISTS (SELECT 1
                FROM bamboo.bb_invoices
                WHERE invoice_number = kz.zef_invoiceno
                AND dateIssued = '1975-09-13');

  OPEN get_time;

  read_time_loop: LOOP
    SET not_found = 0;
    FETCH get_time INTO curr_client_id, ratetype, rate, total_hours, total_days;
    IF not_found THEN
      LEAVE read_time_loop;
    END IF;

    check_existing_block: BEGIN

      DECLARE no_inv_found INT DEFAULT 0;
      DECLARE new_inv_no INT;

      DECLARE get_existing_invoice CURSOR FOR
        SELECT id
        FROM bamboo.bb_invoices
        WHERE client_id = curr_client_id
        AND dateIssued = '1975-09-13';

      DECLARE CONTINUE HANDLER FOR NOT FOUND SET no_inv_found = 1;

      OPEN get_existing_invoice;
      FETCH get_existing_invoice INTO new_inv_no;
      CLOSE get_existing_invoice;

      IF no_inv_found THEN

        INSERT INTO bamboo.bb_invoices (
          client_id, dateIssued, tax1_desc, tax1_rate, tax2_desc, tax2_rate, days_payment_due, invoice_note
        ) VALUES (
          curr_client_id, '1975-09-13', 'VAT', 20.00, '', 0.00, 30, 'New!'
        );

        SET new_inv_no = LAST_INSERT_ID();

        UPDATE bamboo.bb_invoices
        SET invoice_number = new_inv_no
        WHERE id = new_inv_no;

      ELSE

        -- UPDATE bamboo.bb_invoices
        -- SET invoice_note = concat('Existing ' , total_hours)
        -- WHERE id = new_inv_no;

        DELETE FROM bamboo.bb_invoice_items
        WHERE invoice_id = new_inv_no;

      END IF;

      IF ratetype = 'D' THEN
        SET line_quantity = total_days;
      ELSE
        SET line_quantity = total_hours;
      END IF;

      -- Create the invoice line that corresponds with the timesheet summary

      INSERT INTO bamboo.bb_invoice_items (
        invoice_id, amount, quantity, work_description, taxable
      ) VALUES (
        new_inv_no, rate, line_quantity, 'Timesheet-based labour (see backup)', 1
      );

      -- Stamp the timesheet lines with invoice number

      UPDATE kimai_zef kz
      SET zef_invoiceno = new_inv_no
      WHERE EXISTS (SELECT 1
                    FROM kimai_pct_evt ke, kimai_pct kp
                    WHERE ke.evt_id = kz.zef_evtid
                    AND kp.pct_id = ke.pct_id
                    AND kp.pct_kndid = curr_client_id)
      AND kz.zef_invoiceno IS NULL;

    END check_existing_block;

  END LOOP;

  CLOSE get_time;

END;
|

delimiter ;


