SELECT *
FROM mse_text
ORDER BY author , vol , page , para

SELECT *
FROM mse_bible_ref
ORDER BY author, vol, page, para, ref


          $bookid = $chapter = $vstart = $vend = $cv = 0;
          $refvalid = FALSE;

          var $bookid;
          var $chapter;
          var $vstart;
          var $vend;
          var $cv;
          var $refvalid;



SELECT bookname,r.*
FROM mse_bible_ref r, mse_bible_book b
WHERE r.bookid=b.bookid and b.singlechap=1
ORDER BY author,vol,page,para

select author,vol,count(*)
from mse_text
where article_page>0
group by author,vol;

select author,count(*) volumes
from mse_volume
group by author;

update mse_text set article_page = 0
where article_page<>0;

SELECT article,scriptures,page,localrow
FROM `mse_article`
WHERE author = 'JT'
and vol = 10
order by 3


-- zero chapter
SELECT distinct b.bookid, b.bookname
FROM `mse_bible_ref`  r, mse_bible_book b
where r.bookid = b.bookid
and r.chapter = 0;

DELETE FROM mse_bible_ref
WHERE bookid NOT IN (31,57,63,64,65)
AND chapter = 0;


select author,vol,count(*)
from mse_text
where author='GRC'
group by author,vol;

SELECT r.author,r.vol,r.page,r.para,b.bookname
FROM mse_bible_ref r, mse_volume v, mse_bible_book b
WHERE r.author = v.author
AND r.vol = v.vol
AND r.bookid = b.bookid
AND r.chapter <1
AND b.singlechap <> 1
--AND v.complete=1
ORDER BY 1,2,3,4;

