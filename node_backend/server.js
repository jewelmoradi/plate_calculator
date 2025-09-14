const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');

const mealRoutes = require('./routes/meals'); // Importing route file

const app = express();
const PORT = 3000;

app.use(cors()); // Allowing Flutter (on another port) to talk to this backend
app.use(express.json({ limit: '10mb' }));
app.use(express.urlencoded({ limit: '10mb', extended: true }));

// Connecting to MongoDB
mongoose.connect('mongodb://127.0.0.1:27017/plate_calculator_db', {
  useNewUrlParser: true,
  useUnifiedTopology: true,
})
.then(() => console.log('Connected to MongoDB'))
.catch(err => console.error('MongoDB connection error:', err));

// Using the meals route for all /api/meals requests
app.use('/api/meals', mealRoutes);

// Test route
app.get('/', (req, res) => {
  res.send('Backend is working!');
});

app.listen(PORT, () => {
  console.log(`Server running at http://localhost:${PORT}`);
});
