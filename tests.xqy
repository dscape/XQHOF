xquery version "1.0-ml";

import module namespace xqhof = "http://ns.dscape.org/2010/xqhof" 
  at "xqhof.xqy";

(:
 : Testing XQHOF for Mark Logic Server
 :
 : Copyright (c) 2010 Nuno Job [about.nunojob.com]. All Rights Reserved.
 :
 : Licensed under the Apache License, Version 2.0 (the "License");
 : you may not use this file except in compliance with the License.
 : You may obtain a copy of the License at
 :
 : http://www.apache.org/licenses/LICENSE-2.0
 :
 : Unless required by applicable law or agreed to in writing, software
 : distributed under the License is distributed on an "AS IS" BASIS,
 : WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 : See the License for the specific language governing permissions and
 : limitations under the License.
 :
 : The use of the Apache License does not indicate that this project is
 : affiliated with the Apache Software Foundation.
 :)

declare function local:multiply($x, $y) { $x * $y } ;
declare function local:add($x, $y) { $x + $y } ;
declare function local:add_if_even($x, $y) {
  if (($y mod 2) eq 0) then $x+$y else $x } ;
declare function local:factorial($n) { 
  let $multiply := xdmp:function(xs:QName('local:multiply'))
  return xqhof:fold($multiply, 1, 1 to $n) };

declare function local:run() {
  let $multiply := xdmp:function(xs:QName('local:multiply'))
  let $add      := xdmp:function(xs:QName('local:add'))
  let $add_even := xdmp:function(xs:QName('local:add_if_even'))
  let $id       := xdmp:function(xs:QName('xqhof:id'))
  let $folds    := ( (xqhof:fold($multiply, 1, 1 to 3) eq 6),
                     (xqhof:fold($add, 0, 1 to 100) eq 5050),
                     (local:factorial(8) eq 40320),
                     (xqhof:fold($add_even, 0, 1 to 9) eq (2+4+6+8)) )
  return 
    <tests>
      <folds> { xqhof:all($id,$folds) } </folds>
    </tests> } ;

local:run()
