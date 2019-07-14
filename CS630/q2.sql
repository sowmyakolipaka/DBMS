--- find the nearest 4 neighbors to the point with id=11
SELECT p.id, sdo_nn_distance(1) distance
FROM coordinates p, coordinates p1
WHERE p1.id=11 and SDO_NN(p.point,
                        p1.point,
                        'sdo_num_res=5',
                        1
                        )='TRUE'
ORDER BY 2;

