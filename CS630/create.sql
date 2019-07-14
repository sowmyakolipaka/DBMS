--- create table coordinates
CREATE TABLE coordinates
(
 id NUMBER PRIMARY KEY,
 point SDO_GEOMETRY
); 



--- create a spatial index on coordinates.point column
--- create a 500x500 spatial grid, with x and y values ranging from 0 to 500

INSERT INTO user_sdo_geom_metadata 
    (   TABLE_NAME
      , COLUMN_NAME
      , DIMINFO
      ,   SRID)
    VALUES 
   (   'coordinates'
      , 'POINT'
      , SDO_DIM_ARRAY(--- 500x500 grid
           SDO_DIM_ELEMENT('X', 0, 500, 0.005),
           SDO_DIM_ELEMENT('Y', 0, 500, 0.005)
        )
      , null   -- SRID
);
 
CREATE INDEX coordinates_sidx ON coordinates(point) INDEXTYPE IS MDSYS.SPATIAL_INDEX; 

--- load the coordinate points (x,y) from the 30_x_y_coordinates.txt file into the table
INSERT INTO coordinates VALUES (
1,   SDO_GEOMETRY(
                      2001 -- 2 dimensional point
                   ,  null  -- SDO SRID
                   ,  SDO_POINT_TYPE(460,80,null)
                   ,  null
                   ,  null
        )
);
INSERT INTO coordinates VALUES (
2,   SDO_GEOMETRY(
                      2001 -- 2 dimensional point
                   ,  null  -- SDO SRID
                   ,  SDO_POINT_TYPE(200,140,null)
                   ,  null
                   ,  null
        )
);
INSERT INTO coordinates VALUES (
3,   SDO_GEOMETRY(
                      2001 -- 2 dimensional point
                   ,  null  -- SDO SRID
                   ,  SDO_POINT_TYPE(240,260,null)
                   ,  null
                   ,  null
        )
);
INSERT INTO coordinates VALUES (
4,   SDO_GEOMETRY(
                      2001 -- 2 dimensional point
                   ,  null  -- SDO SRID
                   ,  SDO_POINT_TYPE(320,200,null)
                   ,  null
                   ,  null
        )
);
INSERT INTO coordinates VALUES (
5,   SDO_GEOMETRY(
                      2001 -- 2 dimensional point
                   ,  null  -- SDO SRID
                   ,  SDO_POINT_TYPE(340,100,null)
                   ,  null
                   ,  null
        )
);
INSERT INTO coordinates VALUES (
6,   SDO_GEOMETRY(
                      2001 -- 2 dimensional point
                   ,  null  -- SDO SRID
                   ,  SDO_POINT_TYPE(60,100,null)
                   ,  null
                   ,  null
        )
);
INSERT INTO coordinates VALUES (
7,   SDO_GEOMETRY(
                      2001 -- 2 dimensional point
                   ,  null  -- SDO SRID
                   ,  SDO_POINT_TYPE(80,380,null)
                   ,  null
                   ,  null
        )
);
INSERT INTO coordinates VALUES (
8,   SDO_GEOMETRY(
                      2001 -- 2 dimensional point
                   ,  null  -- SDO SRID
                   ,  SDO_POINT_TYPE(240,460,null)
                   ,  null
                   ,  null
        )
);
INSERT INTO coordinates VALUES (
9,   SDO_GEOMETRY(
                      2001 -- 2 dimensional point
                   ,  null  -- SDO SRID
                   ,  SDO_POINT_TYPE(380,260,null)
                   ,  null
                   ,  null
        )
);
INSERT INTO coordinates VALUES (
10,   SDO_GEOMETRY(
                      2001 -- 2 dimensional point
                   ,  null  -- SDO SRID
                   ,  SDO_POINT_TYPE(400,280,null)
                   ,  null
                   ,  null
        )
);
INSERT INTO coordinates VALUES (
11,   SDO_GEOMETRY(
                      2001 -- 2 dimensional point
                   ,  null  -- SDO SRID
                   ,  SDO_POINT_TYPE(400,420,null)
                   ,  null
                   ,  null
        )
);
INSERT INTO coordinates VALUES (
12,   SDO_GEOMETRY(
                      2001 -- 2 dimensional point
                   ,  null  -- SDO SRID
                   ,  SDO_POINT_TYPE(220,100,null)
                   ,  null
                   ,  null
        )
);
INSERT INTO coordinates VALUES (
13,   SDO_GEOMETRY(
                      2001 -- 2 dimensional point
                   ,  null  -- SDO SRID
                   ,  SDO_POINT_TYPE(160,60,null)
                   ,  null
                   ,  null
        )
);
INSERT INTO coordinates VALUES (
14,   SDO_GEOMETRY(
                      2001 -- 2 dimensional point
                   ,  null  -- SDO SRID
                   ,  SDO_POINT_TYPE(60,80,null)
                   ,  null
                   ,  null
        )
);
INSERT INTO coordinates VALUES (
15,   SDO_GEOMETRY(
                      2001 -- 2 dimensional point
                   ,  null  -- SDO SRID
                   ,  SDO_POINT_TYPE(140,460,null)
                   ,  null
                   ,  null
        )
);
INSERT INTO coordinates VALUES (
16,   SDO_GEOMETRY(
                      2001 -- 2 dimensional point
                   ,  null  -- SDO SRID
                   ,  SDO_POINT_TYPE(180,300,null)
                   ,  null
                   ,  null
        )
);
INSERT INTO coordinates VALUES (
17,   SDO_GEOMETRY(
                      2001 -- 2 dimensional point
                   ,  null  -- SDO SRID
                   ,  SDO_POINT_TYPE(460,360,null)
                   ,  null
                   ,  null
        )
);
INSERT INTO coordinates VALUES (
18,   SDO_GEOMETRY(
                      2001 -- 2 dimensional point
                   ,  null  -- SDO SRID
                   ,  SDO_POINT_TYPE(80,320,null)
                   ,  null
                   ,  null
        )
);
INSERT INTO coordinates VALUES (
19,   SDO_GEOMETRY(
                      2001 -- 2 dimensional point
                   ,  null  -- SDO SRID
                   ,  SDO_POINT_TYPE(200,60,null)
                   ,  null
                   ,  null
        )
);
INSERT INTO coordinates VALUES (
20,   SDO_GEOMETRY(
                      2001 -- 2 dimensional point
                   ,  null  -- SDO SRID
                   ,  SDO_POINT_TYPE(320,280,null)
                   ,  null
                   ,  null
        )
);

