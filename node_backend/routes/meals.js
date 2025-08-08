const express = require('express');
const router = express.Router();
const Meal = require('../models/Meal');

// POST /api/meals
router.post('/', async (req, res) => {
    const { imageData, aiResponse } = req.body;

    try {
        const newMeal = new Meal({ imageData, aiResponse });
        await newMeal.save();
        res.status(201).json({ message: 'Meal saved!', meal: newMeal });
    } catch (err) {
        res.status(500).json({ error: 'Failed to save meal.' });
    }
});

// GET /api/meals
router.get('/', async (req, res) => {
  try {
    const meals = await Meal.find().sort({ timestamp: -1 }); // most recent first
    res.json(meals);
  } catch (error) {
    res.status(500).json({ error: 'Failed to fetch meals' });
  }
});

module.exports = router;
