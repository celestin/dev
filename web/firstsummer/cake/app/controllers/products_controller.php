<?php
/* SVN FILE: $Id$ */

/**
 * Enter description here ....
 *
 * @filesource
 * @copyright    Copyright (c) 2006, .
 * @link
 * @package
 * @subpackage
 * @since
 * @version      $Revision$
 * @modifiedby   $LastChangedBy$
 * @lastmodified $Date$
 * @license      http://www.opensource.org/licenses/mit-license.php The MIT License
 */

/**
 * Controller :: Products
 *
 * Enter description here...
 *
 * @package
 * @subpackage
 * @since
 */
class ProductsController extends AppController
{
    var $name = 'Products';

  function index()
  {
    $this->set('data', $this->Product->findAll());
  }

  function view($id)
  {
    $this->set('data', $this->Product->read());
  }

  function add()
  {
    if (empty($this->params['data']))
    {
      $this->render();
    }
    else
    {
      if ($this->Product->save($this->params['data']))
      {
        $this->flash('Your Product has been saved.','/products');
      }
      else
      {
        $this->set('data', $this->params['data']);
        $this->render('edit');
      }
    }
  }

  function edit($id=null)
  {
    if (empty($this->params['data']))
    {
      $this->Product->setId($id);
      $this->params['data'] = $this->Product->read();
      $this->render();
    }
    else
    {
      if ( $this->Product->save($this->params['data']))
      {
        $this->Session->setFlash('Your Product has been updated.');
        //$this->index();
        //$this->render('index');
        $this->redirect('index');
      }
      else
      {
        $this->set('data', $this->params['data']);
        $this->render();
      }
    }
  }

  function delete($id)
  {
    if ($this->Product->del($id))
    {
      $this->flash('The Product with id: '.$id.' has been deleted.', '/products');
    }
  }


}

?>