#include <criterion/criterion.h>
#include <criterion/logging.h>

Test(math, addition)
{
    int result = 2 + 2;
    cr_expect(result == 4, "2 + 2 devrait être égal à 4, mais vaut %d", result);
}

Test(math, subtraction)
{
    int result = 10 - 4;
    cr_assert(result == 6, "10 - 4 devrait être égal à 6, mais vaut %d",
              result);
}

Test(math, failing_example)
{
    int result = 5 * 2;
    cr_expect(result == 9, "Ce test devrait échouer (5 * 2 != 9)");
}
