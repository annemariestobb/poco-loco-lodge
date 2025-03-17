const db = require('../index');
const fs = require('fs');
const path = require('path');

const initializeDatabase = async () => {
  try {
    // Read SQL file
    const schemaSQL = fs.readFileSync(
      path.join(__dirname, 'schema.sql'),
      'utf8'
    );
    
    // Execute SQL
    await db.query(schemaSQL);
    console.log('Database schema initialized successfully');
    
    // Insert sample data
    // You can add initial data here if needed
    
    process.exit(0);
  } catch (err) {
    console.error('Error initializing database:', err);
    process.exit(1);
  }
};

initializeDatabase();