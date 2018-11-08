module washer(d,d2,t) {
   d = d ? d : 5;
   d2 = d2 ? d2 : d*1.8;
   t = t ? t : 1;
   $fn = 200;
   difference() {
   	cylinder(d=d2,h=t);
   	cylinder(d=d+0.5,h=t);
   }
}
