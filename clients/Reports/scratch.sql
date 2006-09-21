CREATE OR REPLACE FORCE VIEW v_rep_sales_invoice AS
  SELECT s.invoice_no, s.raised_date, s.description invoice_description,
    s.project, s.project_title,
    a.activity, a.description activity_description,
    j.job_code, j.description job_description,
    decode(si.billing_type,'301',null,si.total_hours)*1.00 total_hours, si.total_price
  FROM t_sales_invoices s,
       t_si_details si,
       t_activity_cfg a,
       t_job_codes j
  WHERE si.unit = s.unit
  AND si.project = s.project
  AND si.invoice_no = s.invoice_no
  AND a.unit = si.unit
  AND a.parent_project = si.project
  AND a.activity = si.key5
  AND j.unit = si.unit
  AND j.parent_project = si.project
  AND j.job_code = si.key4;


CREATE OR REPLACE FORCE VIEW v_rep_sales_invoice_backup AS
  SELECT b.sales_invoice_no, j.job_code, j.description job_description,
         b.booking_date,b.normal normal_hours
  FROM t_ts_bookings b,
       t_job_codes j
  WHERE b.unit = j.unit
  AND b.project = j.parent_project
  AND b.job_code = j.job_code  
  AND NVL(j.billing_type, '301') = '101';


select *
from v_rep_sales_invoice;

update t_sales_invoices set hard_status='ISSUE',status='ISSUE' where invoice_no='000013';

select *
from t_job_codes
where job_code = '10027';

update t_activity_Cfg set last_inv_date = null where activity = '1011';

update t_sales_invoices 
set description = 'Hosting renewal for partnersinlearning.org.uk'
where invoice_no='000012';

select *
from t_system_parameters;

update t_user_auths
set auth = 'Normal';
