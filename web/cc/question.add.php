<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Add Question Workflow
 * Copyright (c) 2005 frontburner.co.uk
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  27-Dec-2005  File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "Add Question";
include_once 'Main.php';
include 'tpl/top.php';

$uage = NULL;             if (!empty($_POST['uage'])) $uage = $_POST['uage'];
$uquestion = NULL;        if (!empty($_POST['uquestion'])) $uquestion = $_POST['uquestion'];
$uanswer1 = NULL;         if (!empty($_POST['uanswer1'])) $uanswer1 = $_POST['uanswer1'];
$uqtype = NULL;           if (!empty($_POST['uqtype'])) $uqtype = $_POST['uqtype'];
$action = NULL;           if (!empty($_POST['action'])) $action = $_POST['action'];

$memPerson = $_SESSION['member_person'];

//echo "[$uage] [$uquestion] [$uqtype] [$action] ";

if (empty($uage) || empty($uquestion) || empty($uqtype) || empty($action)) {
  Msg::statement("Please enter your question, " . $member->getFirstname() . ".");
  include 'frm/quiz.add.question.php';

} else if (empty($uanswer1) || $action == "ans") {
  Msg::statement("Please answer your question, " . $member->getFirstname() . ".");

  if ($uqtype == "T") {
    include 'frm/quiz.add.answer.text.php';
  } else {
    include 'frm/quiz.add.answer.multi.php';
  }

} else {

  if ($uqtype == "T") {

    $sql = "INSERT INTO question (".
             "memberid, uquestion, uanswer, uage, uqtype, uvalid".
           ") VALUES (".
             "'" . $memPerson->getID() . "', '$uquestion', '$uanswer1', ".
             "'$uage', '$uqtype', '0'".
           ");";
    mysql_query($sql);
    $qid = mysql_insert_id();

    if(mysql_affected_rows() == 1){
      Msg::statement("Your question has been added and will be reviewed.");

      $e = new EmailMsg('Q', $memPerson->getID());
      $e->sendReviewQuestion($qid);
    } else {
      Msg::error("An error occurred adding your question - please try again.");
    }
  }
}

include 'tpl/bot.php';
?>

