<?php
    // Get the posted data.
    $postdata = file_get_contents("php://input");
    
    if(isset($postdata) && !empty($postdata))
    {
   
    // Extract the data.
        $request = json_decode($postdata);
        $fp = fopen("arquivot.txt", "w");
            $escreve = fwrite($fp, $postdata);
        fclose($fp);

        // Validate.
        if(trim($request->model) === '' || (int)$request->price < 1)
        {
            return http_response_code(400);
        }
        $id = $request->id;
        $model = $request->model;
        $price = $request->price;

        try{
            $fp = fopen("arquivo.txt", "a");
            $escreve = fwrite($fp, "$id, $model, $price\n");
            fclose($fp);
            $carro = [
                'model' => $model, 'price' => $price, 'id'=> $id
            ];
            echo json_encode([$carro]);
        } catch (Exception $e){
            http_response_code(422);
        }
    }
?>