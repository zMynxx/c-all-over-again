#include "src/add.h"
#include "/usr/local/bundle/gems/ceedling-0.31.1/vendor/unity/src/unity.h"
















void setUp(void)

{

}



void tearDown(void)

{

}











void test_add(void)

{

  UnityAssertEqualNumber((UNITY_INT)((5)), (UNITY_INT)((add(2, 3))), (

 ((void*)0)

 ), (UNITY_UINT)(48), UNITY_DISPLAY_STYLE_INT);

}
