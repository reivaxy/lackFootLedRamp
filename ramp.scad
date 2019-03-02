$fn=100;
ledBoardY = 11.9;
ledBoardX = 1.1;
ledBoardXoffset = 1.5;

wireY = 6.8;
wireX = 2;

cacheDiam = 15.7;
cacheThick = 1.2;
cacheEdgeDiam = 1.5;

bottomZ = 6;
bottomY = cacheDiam + 2;

backPlate = 1;

baseZ = 6;

/*
rampWireBottom();
translate([0, 30, 0])
  rampBottom();
*/
rampMiddle();

module rampMiddle() {
  ledY = 10;
  difference() {
    rampBottom();
    translate([ledBoardXoffset + ledBoardX, -ledY/2, 0])
      cube([10, ledY, 10]);
    translate([-6, -10, 0])
      cube([20, 20, 2]);
    translate([-6, -10, 14])
      cube([20, 20, 20]);
  }
}

module base() {
  smoother = 10;
  baseY = cacheDiam + 2 + smoother;
  difference() {
    cylinder(d=baseY, h=baseZ);
    removedHalf();
    translate([0, 0, baseZ])
      rotate_extrude(convexity = 10)
        translate([(baseY)/2, 0, 0])
          circle(d = smoother);
    wirePassage();
  }
  backPlate(bottomY, baseZ);
}

module rampWireBottom() {
  base();
  translate([0, 0, baseZ])
    difference() {
      rampBottom();
      wirePassage();
    }
}

module wirePassage() {
    translate([ledBoardXoffset + ledBoardX, -wireY/2, 0])
      cube([wireX, wireY, 10]);
}

module rampBottom() {
  difference() {
    cylinder(d=cacheDiam + 2, h=bottomZ);
    removedHalf();
    translate([0, 0, 2]) {
      cacheSlot(bottomZ);
      // led board slot
      translate([ledBoardXoffset, -ledBoardY/2])
        cube([ledBoardX, ledBoardY, 10]);
    }
  }
  backPlate(cacheDiam + 2, 20);
}

module removedHalf() {
    translate([-20, -20, 0])
      cube([20, 40, 20]);
}
module backPlate(y, z) {
  translate([-backPlate, -y/2, 0])
    cube([backPlate, y, z]);
}
module cacheSlot(height) {
  difference() {
    cylinder(d=cacheDiam, h=height);
    cylinder(d=cacheDiam - cacheThick, h=height);
  }
  translate([cacheEdgeDiam/2 - 0.1, -cacheDiam/2 + cacheEdgeDiam/2, 0])
    cylinder(d=cacheEdgeDiam, h=height);
  translate([cacheEdgeDiam/2 - 0.1, cacheDiam/2 - cacheEdgeDiam/2, 0])
    cylinder(d=cacheEdgeDiam, h=height);
}