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

router.post('/login', async (req, res) => {
  try {
    const { email, password } = req.body;

    // Step 1 — find user by email
    const user = await User.findOne({ email });
    if (!user) {
      return res.status(400).json({ message: "User not found" });
    }

    // Step 2 — check password
    const isMatch = await bcrypt.compare(password, user.password);
    if (!isMatch) {
      return res.status(400).json({ message: "Wrong password" });
    }

    // Step 3 — create token
    const token = jwt.sign(
      { userId: user._id },        // what to store in token
      process.env.JWT_SECRET,      // secret key to sign it
      { expiresIn: '7d' }          // token expires in 7 days
    );

    res.json({ token });

  } catch (err) {
    res.status(500).json({ message: "Server error", error: err.message });
  }
});

module.exports = router;