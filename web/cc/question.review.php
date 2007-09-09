<?
/* * * * * * * * * * * * * * * * * * * * * * * *
 * Review Question Workflow
 * Copyright (c) 2005 frontburner.co.uk
 *
 * $Id$
 *
 * Who  When         Why
 * CAM  27-Dec-2005  File created.
 * * * * * * * * * * * * * * * * * * * * * * * */

$title = "Review Question";
include_once 'Main.php';
include 'tpl/top.php';

$question = NULL;         if (!empty($_GET['question'])) $question = $_GET['question'];
if (empty($question) && !empty($_POST['question'])) $question = $_POST['question'];

$uage = NULL;             if (!empty($_POST['uage'])) $uage = $_POST['uage'];
$uquestion = NULL;        if (!empty($_POST['uquestion'])) $uquestion = $_POST['uquestion'];
$uanswer1 = NULL;         if (!empty($_POST['uanswer1'])) $uanswer1 = $_POST['uanswer1'];
$uqtype = NULL;           if (!empty($_POST['uqtype'])) $uqtype = $_POST['uqtype'];
$action = NULL;           if (!empty($_POST['action'])) $action = $_POST['action'];

$memPerson = $_SESSION['member_person'];

if (empty($action)) {
  $sql = mysql_query("SELECT * ".
                     "FROM question ".
                     "WHERE question=$question");
  if ($row = mysql_fetch_array($sql)) {
    foreach($row AS $key => $val) {
      $$key = stripslashes($val);
    }

    $uanswer1 = $uanswer;
  }

  include 'frm/quiz.review.php';
} else {
  $sql = "UPDATE question SET uvalid = 1 WHERE question = $question";
  mysql_query($sql);

  if(mysql_affected_rows() == 1){
    Msg::statement("The question has been updated.");
  } else {
    Msg::error("An error occurred reviewing the question - please try again.");
  }

}

/*
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
*/
include 'tpl/bot.php';
?>

