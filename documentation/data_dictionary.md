# 📖 Data Dictionary

This document provides detailed information about the datasets used in the Gaming Data Warehouse project. It includes descriptions of each dataset, the fields within those datasets, data types, and any relevant notes or constraints.

## 📂 Datasets

### 1. `sessions`

- **Description**: Contains information about player sessions, including duration, game played, and session date.
- **Fields**:
  - `session_id` (INTEGER): Unique identifier for each session.
  - `player_id` (INTEGER): Foreign key referencing players.
  - `game_id` (INTEGER): Foreign key referencing games.
  - `session_date` (DATE): Date of the session.
  - `duration` (INTEGER): Session duration in minutes.

### 2. `players`

- **Description**: Includes player demographics, experience levels, and usernames.
- **Fields**:
  - `player_id` (INTEGER): Unique identifier for players.
  - `username` (STRING): Player's username.
  - `level` (INTEGER): Player's current level.
  - `experience_points` (INTEGER): Experience points accumulated.
  - `region` (STRING): Player's region.

### 3. `purchases`

- **Description**: Captures player purchases, including item names and prices.
- **Fields**:
  - `purchase_id` (INTEGER): Unique identifier for each purchase.
  - `player_id` (INTEGER): Foreign key referencing players.
  - `item_name` (STRING): Name of the purchased item.
  - `item_price` (FLOAT): Price of the purchased item.
  - `purchase_date` (DATE): Date of the purchase.

## 📝 Notes

- **Data Integrity**: Ensure that `player_id` in `sessions` and `purchases` matches with `player_id` in `players` for accurate data linking.
- **Date Formats**: Dates are stored in `YYYY-MM-DD` format.
- **Currency**: All monetary values are stored in the currency specified in the `item_price` field.

## 🔗 Relationships

- `player_id` is a foreign key in `sessions` and `purchases` linking to `players`.
- `game_id` is used to identify the game in `sessions`.

## 📌 Constraints

- `player_id`, `session_id`, and `purchase_id` must be unique within their respective datasets.
- `item_price` should be a positive value.

