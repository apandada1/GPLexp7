inside octave, run `elastic('force_file', 'angle_file', diameter_of_wire_in_mm, length_in_cm, name_of_graph, no_of_points_in_licear_region_to_fit)`
For example,
```
elastic('thin_wire_force.txt','thin_wire_angle.txt',0.25,82.3,'Thin Wire',8)
```

You might need to update line no. 9, with radius of the wheel.
