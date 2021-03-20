<?php
    $carros = [];
    $carros[0]['id']    = 1;
    $carros[0]['model'] = "Ford Ka";
    $carros[0]['price'] = 53;
    $carros[1]['id']    = 2;
    $carros[1]['model'] = "Fiat Palio";
    $carros[1]['price'] = 48;
    $carros[2]['id']    = 3;
    $carros[2]['model'] = "Honda Fit";
    $carros[2]['price'] = 70;
    $carros[3]['id']    = 4;
    $carros[3]['model'] = "Celta";
    $carros[3]['price'] = 30;
    $carros[4]['id']    = 5;
    $carros[4]['model'] = "Pajero";
    $carros[4]['price'] = 80;
    
    $id = 0;
    $view = "";
    if(isset($_GET['id'])){
        $id = $_GET['id'];
        $view = "single";
    } else {
        $view = "all";
    }
  
    switch($view){
        case "all":
            getAll($carros);
            break;
            
        case "single":
            getNameById($_GET['id'], $carros);
            break;

        case "" :
            //404 - not found;
            break;
    }
   function getNameById($id, $carros){
        foreach ($carros as $carro){
            if($carro['id'] == $id){
                echo json_encode([$carro]);
                break;
            }
        }
    }

    function getAll($carros){
        echo json_encode($carros);
    }




?>