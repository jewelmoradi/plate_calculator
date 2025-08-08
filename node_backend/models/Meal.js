const mongoose = require('mongoose');

const mealSchema = new mongoose.Schema({
  imageData: String,
  aiResponse: String,
  timestamp: { type: Date, default: Date.now }
});

module.exports = mongoose.model('Meal', mealSchema);
