
CREATE TABLE users (
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE accounts (
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    bank_name VARCHAR(100) NOT NULL,
    account_type VARCHAR(50) CHECK (account_type IN ('corrente', 'poupança', 'investimento')),
    balance DECIMAL(18,2) DEFAULT 0,
    created_at TIMESTAMP DEFAULT NOW(),
    user_id INT REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE transactions (
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    amount DECIMAL(18,2) NOT NULL,
    transaction_type VARCHAR(50) CHECK (transaction_type IN ('entrada', 'saída')),
    category VARCHAR(50),
    description TEXT,
    transaction_date TIMESTAMP NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    account_id INT REFERENCES accounts(id) ON DELETE CASCADE
);

CREATE TABLE investments (
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    user_id INT REFERENCES users(id) ON DELETE CASCADE,
    investment_type VARCHAR(50) NOT NULL,
    amount DECIMAL(18,2) NOT NULL,
    start_date TIMESTAMP NOT NULL,
    end_date TIMESTAMP
);