// CEEDLING NOTICE: This generated file only to be consumed for test runner creation

#include "build/vendor/unity/src/unity.h"
#include "src/add.h"

void setUp(void)
{
}

void tearDown(void)
{
}

void test_add(void)
{
  UnityAssertEqualNumber((UNITY_INT)((5)), (UNITY_INT)((add(2, 3))), (

 ((void *)0)

 ), (UNITY_UINT)(48), UNITY_DISPLAY_STYLE_INT);
}
