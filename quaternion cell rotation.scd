

sphere= Spherical(1,azimuth,elevation); ////point coordinate vector

v=Quaternion(0,sphere.x,sphere.y,sphere.z);/// vector as quaternion

	components=[0,1,0].normalizeSum.sqrt;

	i=Quaternion(0, components.[0], 0, 0);
	j=Quaternion(0, 0, components.[1], 0);
	k=Quaternion(0, 0, 0, components.[2]);


rot=(cos(angle.degrad)+(sin(angle.degrad)*(i+j+k))); ////rotation vector with angle of rotatio and ijk xyz normalized components
v1=rot*v*rot.conjugate;