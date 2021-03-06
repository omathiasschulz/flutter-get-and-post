<?php
    // Get the posted data.
    $postdata = file_get_contents("php://input");

    try {
        if(!isset($postdata) || empty($postdata)) {
            throw new Exception('Nenhuma informação encontrada! ');
        }
        // Pegas as informações do post
        $request = json_decode($postdata, true);

        // Valida se as informações foram preenchidas corretamente
        if (
            trim($request['title']) === ''
            || trim($request['text']) === ''
            || trim($request['userEmail']) === ''
            || $request['fakeNews'] === ''
            ) {
            throw new Exception('É necessário preencher todos os campos! ');
        }

        $data = getData();
        $nextId = getNextID($data);

        $novaNoticia = [
            'id' => $nextId,
            'title' => $request['title'],
            'text' => $request['text'],
            'userEmail' => $request['userEmail'],
            'fakeNews' => $request['fakeNews'],
        ];

        // adiciona o noticia no data
        $data[] = $novaNoticia;
        file_put_contents('data/data.json', json_encode($data));

        // TODO - salvar a notícia
        echo '{"status": false, "message": "Sucesso ao inserir notícia! "}';
    } catch (Exception $e) {
        echo '{"status": false, "message": "' . $e->getMessage() . '"}';
    }

    function getData()
    {
        $string = file_get_contents('data/data.json');
        return json_decode($string, true);
    }

    function getNextID($data)
    {
        // pega os ids
        $ids = array_column($data, 'id');
        // verifica qual é o maior
        $max = max($ids);
        // retorna o próximo id
        return $max + 1;
    }
