---
title: "osu!Progress"
description: "Lorem ipsum dolor sit amet"
pubDate: "Jun 20 2024"
---

<style is:global>
h1,
h2,
h3,
h4, ul li { color: #c8cacb }
body { background: #171a1c }
.wrapper, nav::after  {background: #22282a }
p, a, ul { color: #cda637 }
img {
    border: 5px solid;
    border-color: #aaaeaf;
}
</style>

# osu!Progress - track ur scores and time wasted

## Features

- Automaticaly Tracks Passed, Failed, Retrys and Canceld Scores
- Calculates PP and Fullcombo PP
- Tracks Time spend on Any specific Screen
- Tracks BanchoTime (Idle, playing, afk...)
- More or less supports All Modes and Mods
- Shows Potential Fcable Maps
- Progression over time.
- Missanalzer for Passed Scores

# Screenshots

# Arcitectur

- C#
- Liquid for Templates
- Tailwind for Styling
- Sqlite as DB

## Canceld Extension - [osuProgress Server](https://github.com/JuLi0n21/osuprogressserver)

The idea was to extend the concept and make it easy to share local scores only, due to lazer not being supported by the score extraction library at the time and now live score feed being established went no where

# Arcitectur

- golang
- a-h/templ + tailwind
- Sqlite as DB
  ![Score](@assets/osuProgress/scorePage.png)
