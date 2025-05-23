//time:/uodu is now in 3/2,6/2 etc, for it to become 4/2 or 5/2 or 7/2 the same value has to be added to the array every thee values for 4/2 or every six values for 7/2, or two same values added every thee values for 5/2 etc
//another alternative for time would be (not from the sphere) [t1,t2,t3,t4...].normalizeSum.sqrt with t.rand(0.999) and *scalar



///tones// tone selection pl1// ifhe are not rounded the intervals are not known(to the ear) and if used as degrees in a scale they are automatically converted to integers, but not rounded means they represent exact spherical coordinates so all are harmonic to each other no matter what sequence they are, a big soup of harmony.
//if rounded they can represent known intervals and correct degrees in a scale but then they are not exact spheric harmonies rather areas one the sphere. Since the tones are made with three oscillators and defined by the x,y,z of a coordinate they are chords of specific 12-tone degrees in a scale, if that is the choice. Therefore since many coordinates are very close to each other there is an area on the sphere of specific diameter, as long as it takes for the value to be roiunded to the next integer, where this chord is the smae for different coordinates, hence tone areas. These areas can be identfied if we take the az and el arrays pass them to a spherical object and the derive the three rounded x,y,x components.
//In this sence since we have a set array of coordinates, by choosing an azimuth and elevation the respective known chord can be selected. If no pre-fixed spherical model is used, then of-course the coordinates and respective initial choice of azimuth and elevation can be whatever and completely random and float.
//So a pattern can be devised to create sequencies of the known chords acoording to need. But first the chords/areas have to be documented and studied for sequential potential.

///the pl1 tone selection has to have as input the coordinate (spherical) and as ouput the chord




(var chord,sph,pl1=1;
///sph=Spherical(28,~az.[pl1],~el.[pl1]);
sph=Spherical(28,0.degrad,45.degrad);
chord=[sph.x.round(1),sph.y.round(1),sph.z.round(1)];
chord.postln;
)


(
{
var  sph1,sph2,sph3,sph4,sph5,m_x=2,m_y=2,m_z=2;
var az1=0,el1=0,az2=0,el2=0,az3=0,el3=0,mag,mag_x,mag_y,mag_z;
var az4=0,el4=0,az5=0,el5=0,pl1=0,pl2=0,pl3=0,pl4=0,pl5=0;
var angle=0,ang=0;
var azimuth,elevation,magnitudex,magnitudey,magnitudez;
var durx,dury,durz;
var sphx,sphy,sphz,azx,elx,azy,ely,azz,elz,plx=0,ply=0,plz=0;
var num=1.neg;
var ellipsis=[1,1,1],spread=1;
			~az=[];~el=[];~dur=[];

		361.do{
durx=(12).collect{
			azx = (angle+(360*2.pow(plx/12))).wrap(180.neg,180);  // Increment azimuth
				elx = (angle+(180*2.pow(plx/12))).wrap(90.neg,90);
		plx=(plx+1).mod(12);

		sphx=(Spherical(14,(azx.degrad),(elx.degrad))).x.round(1/32);

	};

dury=(12).collect{
		azy = (angle+(360*2.pow(ply/12))).wrap(180.neg,180);  // Increment azimuth
			ely = (angle+(180*2.pow(ply/12))).wrap(90.neg,90);
		ply=(ply+1).mod(12);

		sphy=(Spherical(14,(azy.degrad),(ely.degrad))).y.round(1/32);

	};
durz=(12).collect{
			azz = (angle+(360*2.pow(plz/12))).wrap(180.neg,180);  // Increment azimuth
				elz = (angle+(180*2.pow(plz/12))).wrap(90.neg,90);
		plz=(plz+1).mod(12);

		sphz=(Spherical(14,(azz.degrad),(elz.degrad))).z.round(1/32);

	};

azimuth=(12).collect{

			az1 = (angle+(360*2.pow(pl1/12))).wrap(180.neg,180);  // Increment azimuth
				el1 = (angle+(180*2.pow(pl1/12))).wrap(90.neg,90);
		pl1=(pl1+1).mod(12);

		sph1=(Spherical(1,(az1.degrad),(el1.degrad))).theta.round(0.00001);

	};

elevation=(12).collect{

				az2 = (angle+(360*2.pow(pl2/12))).wrap(180.neg,180);  // Increment azimuth
			el2 = (angle+(180*2.pow(pl2/12))).wrap(90.neg,90);
		pl2=(pl2+1).mod(12);

		sph2=(Spherical(1,(az2.degrad),(el2.degrad))).phi.round(0.00001);

	};

angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);~az=~az++azimuth;~el=~el++elevation;

				12.do{ num=num+1; ~dur=~dur++durx.[num]++dury.[num]++durz.[num];};num=1.neg;};
}.value;

)


(
{
var  sph1,sph2,sph3,sph4,sph5,sph6,sph7,m_x=3,m_y=3,m_z=3,qx,qy,mq=2;
var az1=0,el1=0,az2=0,el2=0,az3=0,el3=0,mag,mag_x,mag_y,mag_z,mag_qx,mag_qy;
var az4=0,el4=0,az5=0,el5=0,az6=0,el6=0,az7=0,el7=0;
var angle=0,ang=0;
var azimuth,elevation,magnitudex,magnitudey,magnitudez;
var durx,dury,durz;
var sphx,sphy,sphz,azx=0,elx=0,azy=0,ely=0,azz=0,elz=0;
var num=1.neg;
var ellipsis=[1,1,1];
var spread=1;
	~dur=[];

durx=(360*8).collect{
			azx = (azx+1).wrap(180.neg,180);  // Increment azimuth
				elx = (elx+(360-(360/1.6180339887499))).wrap(90.neg,90);

		sphx=(Spherical(1,(azx.degrad),(elx.degrad))/Cartesian(ellipsis.normalizeSum.sqrt.[0],ellipsis.normalizeSum.sqrt.[1],ellipsis.normalizeSum.sqrt.[2])).x.round(0.000000001).abs;

	};

dury=(360*8).collect{
		azy = (azy+1).wrap(180.neg,180);  // Increment azimuth
			ely = (ely+(360-(360/1.6180339887499))).wrap(90.neg,90);

		sphy=(Spherical(1,(azy.degrad),(ely.degrad))/Cartesian(ellipsis.normalizeSum.sqrt.[0],ellipsis.normalizeSum.sqrt.[1],ellipsis.normalizeSum.sqrt.[2])).y.round(0.000000001).abs;

	};
durz=(360*8).collect{
			azz = (azz+1).wrap(180.neg,180);  // Increment azimuth
				elz = (elz+(360-(360/1.6180339887499))).wrap(90.neg,90);

		sphz=(Spherical(1,(azz.degrad),(elz.degrad))/Cartesian(ellipsis.normalizeSum.sqrt.[0],ellipsis.normalizeSum.sqrt.[1],ellipsis.normalizeSum.sqrt.[2])).z.round(0.000000001).abs;

	};

~az=(360*8).collect{

			az1 = (az1+1).wrap(180.neg,180);  // Increment azimuth
				el1 = (el1+(360-(360/1.6180339887499))).wrap(90.neg,90);

		sph1=(Spherical(1,(az1.degrad),(el1.degrad))/Cartesian(ellipsis.normalizeSum.sqrt.[0],ellipsis.normalizeSum.sqrt.[1],ellipsis.normalizeSum.sqrt.[2])).theta.round(0.00001);

	};

~el=(360*8).collect{

				az2 = (az2+1).wrap(180.neg,180);  // Increment azimuth
			el2 = (el2+(360-(360/1.6180339887499))).wrap(90.neg,90);

		sph2=(Spherical(1,(az2.degrad),(el2.degrad))/Cartesian(ellipsis.normalizeSum.sqrt.[0],ellipsis.normalizeSum.sqrt.[1],ellipsis.normalizeSum.sqrt.[2])).phi.round(0.00001);

	};


				360.do{ num=num+1; ~dur=~dur++durx.[num]++dury.[num]++durz.[num];}
}.value;
)