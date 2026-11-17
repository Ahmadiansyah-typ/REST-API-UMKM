<?php

namespace App\Controllers\Api;

use App\Models\UmkmModel;
use CodeIgniter\HTTP\ResponseInterface;
use CodeIgniter\RESTful\ResourceController;

class UmkmController extends ResourceController
{
    protected $modelName = UmkmModel::class;
    protected $format    = 'json';

    /** GET /api/umkm */
    public function index(): ResponseInterface
    {
        $model = new UmkmModel();
        $data  = $model->orderBy('id', 'DESC')->findAll();

        return $this->respond([
            'success' => true,
            'message' => 'Data UMKM berhasil diambil',
            'data'    => $data,
        ], 200);
    }

    /** POST /api/umkm */
    public function create(): ResponseInterface
    {
        $data = $this->getRequestData();

        $rules = [
            'nama_umkm' => 'required|min_length[3]|max_length[100]|is_unique[umkm.nama_umkm]',
            'pemilik'   => 'permit_empty|string|max_length[100]',
            'alamat'    => 'permit_empty|string',
            'kategori'  => 'permit_empty|string|max_length[50]',
            'kontak'    => 'permit_empty|string|max_length[20]',
        ];

        $validation = service('validation');
        $validation->reset();
        $validation->setRules($rules);

        if (! $validation->run($data)) {
            return $this->respond([
                'success' => false,
                'message' => 'Validasi gagal',
                'errors'  => $validation->getErrors(),
            ], 400);
        }

        $model   = new UmkmModel();
        $payload = $this->allowedPayload($data);

        if (! $model->insert($payload)) {
            return $this->respond([
                'success' => false,
                'message' => 'Gagal menambahkan data UMKM',
                'errors'  => $model->errors(),
            ], 500);
        }

        $newId   = $model->getInsertID();
        $newData = $model->find($newId);

        return $this->respond([
            'success' => true,
            'message' => 'Data UMKM berhasil ditambahkan',
            'data'    => $newData,
        ], 201);
    }

    /** PUT /api/umkm/{id} */
    public function update($id = null): ResponseInterface
    {
        $model   = new UmkmModel();
        $current = $model->find($id);

        if ($current === null) {
            return $this->respond([
                'success' => false,
                'message' => 'Data UMKM tidak ditemukan',
                'errors'  => ['id' => 'Data UMKM dengan ID tersebut tidak ditemukan'],
            ], 404);
        }

        $data = $this->getRequestData();
        $rules = [
            'nama_umkm' => 'required|min_length[3]|max_length[100]',
            'pemilik'   => 'permit_empty|string|max_length[100]',
            'alamat'    => 'permit_empty|string',
            'kategori'  => 'permit_empty|string|max_length[50]',
            'kontak'    => 'permit_empty|string|max_length[20]',
        ];

        $validation = service('validation');
        $validation->reset();
        $validation->setRules($rules);

        if (! $validation->run($data)) {
            return $this->respond([
                'success' => false,
                'message' => 'Validasi gagal',
                'errors'  => $validation->getErrors(),
            ], 400);
        }

        if (! $model->update($id, $this->allowedPayload($data))) {
            return $this->respond([
                'success' => false,
                'message' => 'Gagal memperbarui data UMKM',
                'errors'  => $model->errors(),
            ], 500);
        }

        return $this->respond([
            'success' => true,
            'message' => 'Data UMKM berhasil diperbarui',
            'data'    => $model->find($id),
        ], 200);
    }

    /** DELETE /api/umkm/{id} */
    public function delete($id = null): ResponseInterface
    {
        $model = new UmkmModel();
        $row   = $model->find($id);

        if ($row === null) {
            return $this->respond([
                'success' => false,
                'message' => 'Data UMKM tidak ditemukan',
                'errors'  => ['id' => 'Data UMKM dengan ID tersebut tidak ditemukan'],
            ], 404);
        }

        if (! $model->delete($id)) {
            return $this->respond([
                'success' => false,
                'message' => 'Gagal menghapus data UMKM',
                'errors'  => ['database' => 'Data tidak dapat dihapus'],
            ], 500);
        }

        return $this->respond([
            'success' => true,
            'message' => 'Data UMKM berhasil dihapus',
            'data'    => [
                'id'        => (int) $row['id'],
                'nama_umkm' => $row['nama_umkm'],
            ],
        ], 200);
    }

    /**
     * Mendukung request JSON dan form-urlencoded.
     * PDF praktikum menggunakan getPost() untuk POST dan getRawInput() untuk PUT.
     */
    private function getRequestData(): array
    {
        $json = $this->request->getJSON(true);

        if (is_array($json)) {
            return $json;
        }

        if (strtolower($this->request->getMethod()) === 'put') {
            return $this->request->getRawInput();
        }

        return $this->request->getPost();
    }

    /** Batasi field yang dapat disimpan sesuai UmkmModel::$allowedFields. */
    private function allowedPayload(array $data): array
    {
        $allowed = ['nama_umkm', 'pemilik', 'alamat', 'kategori', 'kontak'];
        $payload = array_intersect_key($data, array_flip($allowed));

        foreach ($payload as $key => $value) {
            if (is_string($value)) {
                $payload[$key] = trim($value);
                if ($payload[$key] === '' && $key !== 'nama_umkm') {
                    $payload[$key] = null;
                }
            }
        }

        return $payload;
    }
}
