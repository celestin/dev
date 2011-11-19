-- ----------------------------------------------------------------------------
-- FBtracker Interface
-- Copyright (c) 2010 Front Burner
-- Author Craig McKay <craig@frontburner.co.uk>
--
-- $Id$
--
-- Who  When         Why
-- CAM  19-Nov-2011  11065 : Added extra fields to interface.
-- ----------------------------------------------------------------------------


-- ----------------------------------------------------------------------------
-- fbtracker_bugs_insert copies new bugs from Bugzilla to Kimai
-- ----------------------------------------------------------------------------

DROP TRIGGER IF EXISTS bugs.fbtracker_bugs_insert;

delimiter |

CREATE TRIGGER bugs.fbtracker_bugs_insert AFTER INSERT ON bugs.bugs

  FOR EACH ROW BEGIN

    -- Copy Bugzilla Products to Kimai Projects

    INSERT INTO kimai.kimai_pct (pct_id, pct_kndid, pct_name, pct_comment)
    SELECT bp.id, kk.knd_id, bp.name, bp.description
    FROM bugs.products bp, kimai.kimai_knd kk
    WHERE kk.knd_id = bp.description
    AND NOT EXISTS (SELECT 1
    FROM kimai.kimai_pct
    WHERE pct_id = bp.id);

    -- Set up Kimai Project permissions

    INSERT INTO kimai.kimai_grp_pct (grp_id, pct_id)
    SELECT 1, kp.pct_id
    FROM kimai.kimai_pct kp
    WHERE NOT EXISTS (SELECT 1
    FROM kimai.kimai_grp_pct
    WHERE pct_id = kp.pct_id);

    -- Copy new Bugzilla Bugs to Kimai Tasks

    INSERT INTO kimai.kimai_evt (evt_id, evt_comment, evt_name)
    SELECT bug_id, short_desc, CONCAT(bug_id, ' - ', short_desc) AS evt_name
    FROM bugs.bugs bb
    WHERE NOT EXISTS (SELECT 1
    FROM kimai.kimai_evt WHERE evt_id = bb.bug_id)
    AND EXISTS (SELECT 1
    FROM kimai.kimai_pct WHERE pct_id = bb.product_id);

    -- Set up Kimai Project / Task assignment

    INSERT INTO kimai.kimai_pct_evt (pct_id, evt_id)
    SELECT product_id, bug_id
    FROM bugs.bugs bb
    WHERE NOT EXISTS (SELECT 1
    FROM kimai.kimai_pct_evt WHERE evt_id = bb.bug_id)
    AND EXISTS (SELECT 1
    FROM kimai.kimai_pct WHERE pct_id = bb.product_id);

    -- Set up Kimai Task permissions

    INSERT INTO kimai.kimai_grp_evt (grp_id, evt_id)
    SELECT 1, ke.evt_id
    FROM kimai.kimai_evt ke
    WHERE NOT EXISTS (SELECT 1
    FROM kimai.kimai_grp_evt
    WHERE evt_id = ke.evt_id);

  END;
|

delimiter ;




-- ----------------------------------------------------------------------------
-- fbtracker_bugs_update updates changed bugs from Bugzilla to Kimai
-- ----------------------------------------------------------------------------

DROP TRIGGER IF EXISTS bugs.fbtracker_bugs_update;

delimiter |

CREATE TRIGGER bugs.fbtracker_bugs_update AFTER UPDATE ON bugs.bugs

  FOR EACH ROW BEGIN

    -- Update Bugzilla Bug description changes to Kimai Task

    UPDATE kimai.kimai_evt
    SET evt_comment = (SELECT short_desc FROM bugs.bugs WHERE bug_id = kimai.kimai_evt.evt_id),
    evt_name = (SELECT CONCAT(bug_id, ' - ', short_desc) FROM bugs.bugs WHERE bug_id = kimai.kimai_evt.evt_id)
    WHERE EXISTS (SELECT 1 FROM bugs.bugs WHERE bug_id = kimai.kimai_evt.evt_id);

    -- Copy Bugzilla Bug status to Kimai Task status

    UPDATE kimai.kimai_evt
    SET evt_trash = (SELECT CASE bugs.bug_status WHEN 'VERIFIED' THEN 1 WHEN 'CLOSED' THEN 1 ELSE 0 END FROM bugs.bugs WHERE bug_id = kimai.kimai_evt.evt_id)
    WHERE EXISTS (SELECT 1 FROM bugs.bugs WHERE bug_id = kimai.kimai_evt.evt_id);

    -- Generate invoices

    CALL kimai.fbtracker_generate_invoice();

  END;
|

delimiter ;





-- ----------------------------------------------------------------------------
-- fbtracker_kimaiclient_insert copies new clients from Kimai to Bamboo
-- ----------------------------------------------------------------------------

DROP TRIGGER IF EXISTS kimai.fbtracker_kimaiclient_insert;

delimiter |

CREATE TRIGGER kimai.fbtracker_kimaiclient_insert AFTER INSERT ON kimai.kimai_knd

  FOR EACH ROW BEGIN

    -- Copy Kimai Customers to Bamboo Clients

    INSERT INTO bamboo.bb_clients (id, name, address1, city, postal_code, website, tax_status, rate, ratetype)
    SELECT knd_id, knd_name, knd_street, knd_city, knd_zipcode, knd_homepage, 1, 25, 'H'
    FROM kimai.kimai_knd kk
    WHERE NOT EXISTS (SELECT 1
    FROM bamboo.bb_clients
    WHERE id = kk.knd_id);

  END;
|

delimiter ;





-- ----------------------------------------------------------------------------
-- fbtracker_kimaiclient_udate copies changed clients from Kimai to Bamboo
-- ----------------------------------------------------------------------------

DROP TRIGGER IF EXISTS kimai.fbtracker_kimaiclient_udate;

delimiter |

CREATE TRIGGER kimai.fbtracker_kimaiclient_udate AFTER UPDATE ON kimai.kimai_knd

  FOR EACH ROW BEGIN

    -- Update Kimai Customers changes to Bamboo Clients

    UPDATE bamboo.bb_clients bc
    SET name = (SELECT knd_name FROM kimai.kimai_knd WHERE knd_id = bc.id)
    WHERE EXISTS (SELECT 1 FROM kimai.kimai_knd WHERE knd_id = bc.id);

    UPDATE bamboo.bb_clients bc
    SET address1 = (SELECT knd_street FROM kimai.kimai_knd WHERE knd_id = bc.id)
    WHERE EXISTS (SELECT 1 FROM kimai.kimai_knd WHERE knd_id = bc.id);

    UPDATE bamboo.bb_clients bc
    SET city = (SELECT knd_city FROM kimai.kimai_knd WHERE knd_id = bc.id)
    WHERE EXISTS (SELECT 1 FROM kimai.kimai_knd WHERE knd_id = bc.id);

    UPDATE bamboo.bb_clients bc
    SET postal_code = (SELECT knd_zipcode FROM kimai.kimai_knd WHERE knd_id = bc.id)
    WHERE EXISTS (SELECT 1 FROM kimai.kimai_knd WHERE knd_id = bc.id);

    UPDATE bamboo.bb_clients bc
    SET website = (SELECT knd_homepage FROM kimai.kimai_knd WHERE knd_id = bc.id)
    WHERE EXISTS (SELECT 1 FROM kimai.kimai_knd WHERE knd_id = bc.id);

  END;
|

delimiter ;




