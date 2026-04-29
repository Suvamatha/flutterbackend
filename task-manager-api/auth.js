const express = require('express');
const router = express.Router();
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const User = require('./user'); // 👈 capital U, matches model name

router.post('/register', async (req, res) => {
  try {
    const { email, password } = req.body;

    if (!email || !password) {
      return res.status(400).json({ message: "Email and password required" });
    }

    // Step 1 — hash password
    const hashedPassword = await bcrypt.hash(password, 10);

    // Step 2 — save user with hashed password
    const newUser = await User.create({ email, password: hashedPassword });

    res.status(201).json({ message: "User created!" });

  } catch (err) {
    res.status(500).json({ message: "Server error", error: err.message });
  }
});

module.exports = router;