<?php

namespace App\Controllers;

use App\Models\MahasiswaModel;
use CodeIgniter\RESTful\ResourceController;

class Mahasiswa extends ResourceController
{
    protected $format = 'json';
    protected $model;

    public function __construct()
    {
        // INI WAJIB
        $this->model = new MahasiswaModel();
    }

    /**
     * GET /mahasiswa
     */
    public function index()
    {
        return $this->respond([
            'status' => true,
            'data'   => $this->model->findAll()
        ]);
    }

    /**
     * POST /mahasiswa
     */
        public function create()
        {
            $data = $this->request->getJSON(true);

            if (!$data) {
                return $this->respond([
                    'status' => false,
                    'message' => 'Data kosong'
                ], 400);
            }

            $this->model->insert($data);

            return $this->respond([
                'status' => true,
                'message' => 'Mahasiswa berhasil ditambahkan'
            ], 201);
        }


    /**
     * GET /mahasiswa/{id}
     */
    public function show($id = null)
    {
        $data = $this->model->find($id);

        if (!$data) {
            return $this->failNotFound('Data tidak ditemukan');
        }

        return $this->respond([
            'status' => true,
            'data'   => $data
        ]);
    }

    /**
     * PUT /mahasiswa/{id}
     */
    public function update($id = null)
    {
        $data = $this->request->getJSON(true);

        $this->model->update($id, $data);

        return $this->respond([
            'status' => true,
            'message' => 'Mahasiswa berhasil diupdate'
        ]);
    }

    /**
     * DELETE /mahasiswa/{id}
     */
    public function delete($id = null)
    {
        if (!$this->model->find($id)) {
            return $this->failNotFound('Data tidak ditemukan');
        }

        $this->model->delete($id);

        return $this->respondDeleted([
            'status'  => true,
            'message' => 'Data berhasil dihapus'
        ]);
    }
}
