--- find the nearest 4 neighbors to point (240,460)
SELECT p.id, sdo_nn_distance(1) distance
FROM coordinates p
WHERE SDO_NN(p.point,
                        SDO_GEOMETRY(2001
                                ,    null
                                ,    SDO_POINT_TYPE(0,0,null)
                                ,    null
                                ,    null
                                ),
                        'sdo_num_res=5',
                        1
                        )='TRUE'
;
--ORDER BY 2;

