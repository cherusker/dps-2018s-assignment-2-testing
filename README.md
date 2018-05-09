# Don't Be Stupid!

Do **NOT HAND IN** any of these test cases (ever). It's really simple to come up with your own facts ;)

# No Guarantees ...

These test cases are not official. This means that there are no guarantees whatsoever. They are definitely not complete and might even test wrong things right. If you detect any issues, feel free to correct them using pull requests. I am very happy to merge improvements.

# Contribute!

Please share your test cases as well. The more tests we have, the better we can verify *all* of our solutions :) Just send pull requests and I will merge them immediately.

# How to Run the Tests?

I encourage you to use the test driver `run.sh`. It should work on most Unix-like platforms with a bash. It automatically runs all available tests and prints the results. Depending on your folder structure, you might have to change a few things:

- `dlvexe`: path to the DLV executable
- `guessTestsRootFolder`: the root folder of guess tests (could stay untouched)
- `checkTestsRootFolder`: the root folder of check tests (could stay untouched)
- `guessProgram`: path to your guess program
- `checkProgram`: path to your check program
- `runGuessTests`: 0 or 1 (set as you like)
- `runCheckTests`: 0 or 1 (set as you like)
- `stopOnFailure`: 0 or 1 (set as you like)

Note that, depending on your system, you might have to explicitely set executable rights for `run.sh` like:

`chmod +x run.sh`

That's it. Enjoy.

Also, if anyone feels like porting the test driver for Windows feel free to do so and send a PR - I would love to merge that as well :)
