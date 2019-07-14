--- create a MBR using the indexes of all the returned geometries
SELECT sdo_aggr_mbr(point)
FROM coordinates c
WHERE c.id in (
(SELECT p.id
FROM coordinates p
WHERE SDO_NN(p.point,
                        SDO_GEOMETRY(2001
                                ,    null
                                ,    SDO_POINT_TYPE(240,460,null)
                                ,    null
                                ,    null
                                ),
                        'sdo_num_res=5',
                        1
                        )='TRUE'
)
);
