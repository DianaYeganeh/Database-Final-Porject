# Insurance Management System Database

A comprehensive PostgreSQL database solution for managing insurance operations including clients, policies, claims, payments, and agent information.

## Overview

This Insurance Management System provides a robust database structure designed to efficiently store and manage all aspects of an insurance company's operations. The system handles client information, insurance policies, claims processing, payment tracking, and agent management.

## Database Schema

The database consists of the following main tables:

- **Client**: Stores customer details including personal information and contact details
- **Insurance Type**: Contains different insurance product offerings and their details
- **Policy**: Records insurance policies linked to clients, insurance types, and agents
- **Claim**: Tracks claims made against policies including status and resolution details
- **Agent**: Maintains information about insurance agents/employees
- **Payment**: Records payment transactions related to policies

## Entity-Relationship Diagram

The repository includes an ER diagram (`insurance-er-diagram.mermaid`) that visually represents the relationships between all tables in the system. Key relationships include:

- Clients can have multiple policies
- Each policy belongs to a specific insurance type
- Agents manage multiple policies
- Policies can generate multiple claims
- Policies require multiple payments

## Files in this Repository

1. **insurance-db-schema.sql**
   - Complete PostgreSQL schema definition
   - Creates all tables with proper constraints and relationships
   - Includes indexes for performance optimization

2. **insurance-er-diagram.mermaid**
   - Visual representation of the database structure using Mermaid diagram syntax
   - Shows all tables, their attributes, and relationships

3. **insurance-sample-data.sql**
   - Sample data for testing and demonstration
   - Includes realistic entries for all tables in the system

4. **insurance-useful-queries.sql**
   - Collection of common SQL queries for the system
   - Provides examples for various business reporting needs
   - Demonstrates complex joins and aggregations

## Key Features

- **Comprehensive Schema**: Properly normalized database design with appropriate relationships
- **Data Integrity**: Enforced through primary keys, foreign keys, and check constraints
- **Performance Optimization**: Strategic indexes on frequently queried columns
- **Business Logic**: Check constraints ensure business rules are followed (e.g., end date > start date)
- **Reporting Support**: Sample queries demonstrate how to extract meaningful business insights

## Sample Queries

The system includes several pre-built queries for common operations:

- List all policies for a specific client
- Find policies expiring in the next 30 days
- Calculate claim statistics by insurance type
- Identify pending payments
- Determine agent performance and commissions
- Locate high-risk policies with significant claim ratios
- Analyze claim frequency by geographic location

## Getting Started

### Prerequisites

- PostgreSQL 10.0 or higher
- Basic knowledge of SQL and database management

### Installation

1. Clone this repository
2. Connect to your PostgreSQL instance
3. Execute the schema creation script:
   ```
   psql -U your_username -d your_database -f insurance-db-schema.sql
   ```
4. (Optional) Load the sample data:
   ```
   psql -U your_username -d your_database -f insurance-sample-data.sql
   ```

## Usage

After setting up the database, you can:

1. Use the provided queries in `insurance-useful-queries.sql` as templates for your own reporting needs
2. Integrate the database with your frontend applications
3. Extend the schema as needed for your specific business requirements
