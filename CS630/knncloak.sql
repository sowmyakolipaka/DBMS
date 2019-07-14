SET SERVEROUTPUT ON

  create or replace function circle(
  center sdo_geometry,
  radius number
)
return sdo_geometry
is
  x number;
  y number;
begin
  x := center.sdo_point.x;
  y := center.sdo_point.y;
  return sdo_geometry (
     SELECT p.id, sdo_nn_distance(1) distance
FROM coordinates p, coordinates p1
WHERE SDO_NN(p.point,
                        SDO_GEOMETRY(2001
                                ,    null
                                ,    SDO_POINT_TYPE(0,0,null)
                                ,    null
                                ,    null
                                ),
                        'sdo_num_res=3',
                        1
                        )='TRUE'

and p1.pid <> p2.pid
    );
)
end;	
	
	
	
	
	
	create or replace function rectangle_from_points (
  point_1 sdo_geometry,
  point_2 sdo_geometry
) 
return sdo_geometry
as 
  rectangle sdo_geometry;
begin
  -- Initialize resulting rectangle
  rectangle := sdo_geometry (2003, point_1.sdo_srid, null,
     sdo_elem_info_array (1,1003,3),
     sdo_ordinate_array()
  );
  with mbr as 
(select rownum coord_seq, column_value coord from coordinates (select sdo_aggr_mbr(shape).sdo_ordinates 
  from coordinates)) 
 SELECT sdo_geom.sdo_min_mbr_ordinate(geom,1) as MINX,
            sdo_geom.sdo_max_mbr_ordinate(geom,1) as MAXX,
             sdo_geom.sdo_min_mbr_ordinate(geom,2) as MINY,
             sdo_geom.sdo_max_mbr_ordinate(geom,2) as MAXY
        FROM coordinates P );
		);
  -- Return it
  return rectangle;
  
		CURSOR curs_points IS rectangle (MINX,MAXX,MINY,MAXY)
		FETCH curs_points INTO RECTANGLE_cordinates;
		EXIT WHEN 
    center_x = (MINX + MAXX)/2
    center_y = (MINY + MAXY)/2
    center_point = dot( [ center_x, center_y ], R );
	end;
	
