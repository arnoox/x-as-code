#include <gtest/gtest.h>

// Demonstrate some basic assertions.
TEST(EacTest, BasicAssertions) {
  // Expect two strings not to be equal.
  EXPECT_STRNE("un", "eac");
  // Expect equality.
  EXPECT_EQ(7 * 6, 42);
}