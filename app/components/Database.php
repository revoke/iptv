<?php

namespace App;

use \Nette\Utils\Strings;

class Repository
{
    /** @var \Nette\Database\Context */
    public $database;

    private $table;
    
    public function __construct(\Nette\Database\Context $database)
    {
        $this->database = $database;
        
        $this->table = $this->getTableName();
    }
    
    
    /**
     * nazev tridy s prefixovanymi velkymi pismeny uvnitr nazvu tridy transformuji na podtrzitka
     * @return string
     */
    private function getTableName() : string
    {
        $classPath = get_class($this);
        $className = Strings::after($classPath, '\\', -1);
        $tableName = Strings::replace($className, '~(.{1})([A-Z])~', '$1$2');
        return $tableName;
    }
    
    /**
     * @return \Nette\Database\Table\Selection
     */
    public function table() : \Nette\Database\Table\Selection
    {
        try
        {
            return $this->database->table($this->table);
        }
        catch (\Nette\InvalidArgumentException $exception)
        {
            die($exception->getMessage());
        }
        catch (\Nette\Database\DriverException $exception)
        {
            die($exception->getMessage());
            # toto je jednoduchy import dat
            if (Strings::Match($exception->getMessage(), "~^Table '[\w]+' does not exist.$~"))
            {
                $this->database->query(file_get_contents(APP_DIR . '/../data/database_schema.sql'));
                $this->database->query(file_get_contents(APP_DIR . '/../data/database_data.sql'));
            }
        }
    }
    
    
    /**
     * Inserts row in a table.
     * @param  array|\Traversable|Selection array($column => $value)|\Traversable|Selection for INSERT ... SELECT
     * @return IRow|int|bool Returns IRow or number of affected rows for Selection or table without primary key
     */
    public function insert($data)
    {
        return $this->table()->insert($data);
    }
    
    
    /**
     * 
     * @param int $id
     * @return int
     */
    public function delete(int $id) : int
    {
        return $this->table()->wherePrimary($id)->delete();
    }
    
    
    /**
     * @param int $id
     * @param iterable ($column => $value) $data
     * @return int number of affected rows
     */
    public function update(int $id, $data) : int
    {
        return $this->table()->wherePrimary($id)->update($data);
    }
    
    
    /**
     * @param int $id
     * @return \Nette\Database\Table\ActiveRow|false if there is no such row
     */
    public function get(int $id)
    {
        return $this->table()->get($id);
    }
    
    
    /**
     * @return \Nette\Database\Table\ActiveRow|false
     */
    public function findById($id)
    {
        return $this->table()->where(['id' => $id])->fetch();
    }
    
    
    /**
     * @return \Nette\Database\Table\ActiveRow|false
     */
    public function findOneBy($condition)
    {
        return $this->table()->where($condition)->fetch();
    }
    
    
    /**
     * @param array $where
     * @return \Nette\Database\Table\Selection
     */
    public function findBy($where) : \Nette\Database\Table\Selection
    {
        return $this->table()->where($where);
    }
    
    
    /**
     * @return \Nette\Database\Table\Selection
     */
    public function findAll() : \Nette\Database\Table\Selection
    {
        return $this->table();
    }
}