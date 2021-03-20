<?php

    // valida o tipo de tela
    $tipoTela = '';
    if(isset($_GET['id'])) {
        $id = $_GET['id'];
        $tipoTela = 'one';
    } else {
        $tipoTela = 'all';
    }

    // pega os dados que estão salvos no JSON
    $data = getData();

    // apresenta a tela
    switch($tipoTela) {
        case 'one':
            getOneById($_GET['id'], $data);
            break;
        case 'all':
            getAll($data);
            break;
        default:
            // 404 - not found;
            break;
    }

    function getData()
    {
        $string = file_get_contents('data/data.json');
        return json_decode($string, true);
    }

    function getOneById($id, $data)
    {
        foreach ($data as $dataAtual) {
            if($dataAtual['id'] == $id) {
                echo json_encode($dataAtual);
                break;
            }
        }
    }

    function getAll($data)
    {
        echo json_encode($data);
    }
