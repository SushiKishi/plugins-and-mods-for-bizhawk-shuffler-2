# Weighted Odds Mod for Bizhawk Shuffler 2

 * New release under development.
 


## What will this do?

This is a direct modification of Bizhawk Shuffler 2 to give it the ability to choose the next game based on weighted odds -- as in, the longer a game goes without being picked, the more likely it is to be picked.  This may "feel" more random, even if it technically isn't.

Each game starts with one 'lottery ticket.' When a game is selected and played, it loses all of its tickets. When a game is NOT selected, it gains one ticket.  The Shuffler pulls a random number from all the assigned tickets to pick the next game.

If you are playing a 6 game Shuffler, and somehow by chance the games are picked exactly in order for the first five swaps, then the odds of each game being chosen are as follows:


|        |                     | Shuffler Start | Swap 1: Game 1 | Swap 2: Game 2 | Swap 3: Game 3 | Swap 4: Game 4 | Swap 5: Game 5 |
|--------|---------------------|----------------|----------------|----------------|----------------|----------------|----------------|
| Game 1 | Random Shuffle Odds | 1/6 - ~16.6%   | None           | 1/6 - 16.6%    | 1/6 - 16.6%    | 1/6 - 16.6%    | 1/6 - 16.6%    |
|        | Weighted Odds       | 1/6 - ~16.6%   | None           | 1/13 - ~7.6%   | 2/15 - ~13.3%  | 3/16 - 18.75%  | 4/16 - 25%     |
| Game 2 | Random Shuffle Odds | 1/6 - ~16.6%   | 1/6 - ~16.6%   | None           | 1/6 - ~16.6%   | 1/6 - ~16.6%   | 1/6 - ~16.6%   |
|        | Weighted Odds       | 1/6 - ~16.6%   | 2/10 - 20%     | None           | 1/15 - ~6.7%   | 2/16 - 12.5%   | 3/16 - 18.75%  |
| Game 3 | Random Shuffle Odds | 1/6 - ~16.6%   | 1/6 - ~16.6%   | 1/6 - ~16.6%   | None           | 1/6 - ~16.6%   | 1/6 - ~16.6%   |
|        | Weighted Odds       | 1/6 - ~16.6%   | 2/10 - 20%     | 3/13 - ~23%    | None           | 1/16 - 6.25%   | 2/16 - 12.5%   |
| Game 4 | Random Shuffle Odds | 1/6 - ~16.6%   | 1/6 - ~16.6%   | 1/6 - ~16.6%   | 1/6 - ~16.6%   | None           | 1/6 - ~16.6%   |
|        | Weighted Odds       | 1/6 - ~16.6%   | 2/10 - 20%     | 3/13 - ~23%    | 4/15 - ~26.7%  | None           | 1/16 - 6.25%   |
| Game 5 | Random Shuffle Odds | 1/6 - ~16.6%   | 1/6 - ~16.6%   | 1/6 - ~16.6%   | 1/6 - ~16.6%   | 1/6 - ~16.6%   | None           |
|        | Weighted Odds       | 1/6 - ~16.6%   | 2/10 - 20%     | 3/13 - ~23%    | 4/15 - ~26.7%  | 5/16 - 31.25%  | None           |
| Game 6 | Random Shuffle Odds | 1/6 - ~16.6%   | 1/6 - ~16.6%   | 1/6 - ~16.6%   | 1/6 - ~16.6%   | 1/6 - ~16.6%   | 1/6 - ~16.6%   |
|        | Weighted Odds       | 1/6 - ~16.6%   | 2/10 - 20%     | 3/13 - ~23%    | 4/15 - ~26.7%  | 5/16 - 31.25%  | 6/16 - 37.5%   |


## How to use it

Bizhawk Shuffler 2 does not appear to have any official releases or versioning, which makes some of this difficult.  This feature has not been officially added, which also makes things difficult.

This mod was last updated on the date stated above. It contains the entire Bizhawk Shuffler code, as of that date, including the Weighted Odds modifications.

Any new features added to BS2 since then will not be present here.  It may or may not work on the newest version of Bizhawk.  Versioning information is at the top of the page.

## Okay but that didn't answer the question

OK, so you know how the official Bizhawk Shuffler 2 instructions say to download that file and extract it directly into your Bizhawk folder? You do the same thing, but with this file instead.  It is a complete installaion of the Bizhawk Shuffler.


## FAQs

Q: Something isn't working.
A: You can send me a friendly message @SushiKishi wherever you tune in to at symbols. The fastest way to get playing again is to use an official version of the Bizhawk Shuffler. It's unlikely I can help much. You will get no support from official BS2 channels with this.

