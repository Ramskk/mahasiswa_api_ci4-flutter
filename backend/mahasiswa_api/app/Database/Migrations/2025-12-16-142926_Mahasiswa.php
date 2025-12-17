<?php


namespace App\Database\Migrations;


use CodeIgniter\Database\Migration;


class Mahasiswa extends Migration
{
public function up()
{
$this->forge->addField([
'id' => [
'type' => 'INT',
'constraint' => 11,
'unsigned' => true,
'auto_increment' => true,
],
'nama' => [
'type' => 'VARCHAR',
'constraint' => 100,
],
'nim' => [
'type' => 'VARCHAR',
'constraint' => 20,
'unique' => true,
],
'prodi' => [
'type' => 'VARCHAR',
'constraint' => 50,
],
'created_at DATETIME DEFAULT CURRENT_TIMESTAMP',
'updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP'
]);


$this->forge->addKey('id', true);
$this->forge->createTable('mahasiswa');
}


public function down()
{
$this->forge->dropTable('mahasiswa');
}
}