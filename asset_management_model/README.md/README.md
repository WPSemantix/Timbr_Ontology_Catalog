# Asset Management Model

## Overview
The Asset Management Model is designed to help organizations effectively track and manage their physical and digital assets. By organizing data about assets, such as their locations, inventory status, and maintenance schedules, this model provides a clear structure for managing assets throughout their lifecycle. It connects core concepts like `Asset`, `Inventory`, and `Location` with related elements such as `Maintenance Schedules`, `Technicians`, and `Vendors`, ensuring that assets are well-maintained, properly allocated, and available when needed.

## Key Concepts
- **Asset**: The items being tracked, which can be either physical (like equipment) or digital (like software).
- **Inventory**: Details the quantity of assets available and their types.
- **Location**: Tracks where assets are physically located or assigned.
- **Maintenance Schedule**: Keeps track of when and how often assets need to be serviced.
- **Part**: Represents individual components that are part of an asset.
- **Technician**: Refers to the people responsible for maintaining and repairing assets.
- **Vendor**: Represents external providers of assets or maintenance services.
- **Work Order**: Specific tasks assigned to technicians or vendors for maintenance or other services related to assets.

## Asset Management Diagram

![Attached Image of Model](path/to/image.png)

The model in Timbr’s Ontology Explorer, which provides a graphical interface to easily view and manage the concepts, properties, and relationships of the business model.

## SQL Setup
To implement the Asset Management Model in Timbr, simply run the SQL script found in the [SQL Folder](./sql). This script will create the necessary entities and relationships within your knowledge graph.

## Implementation Guide
For step-by-step instructions on setting up this model in Timbr, refer to the tutorial located in the [Tutorial Folder](./tutorial). It will guide you through the process of accessing Timbr, creating a new knowledge graph, and running the SQL script in the SQL editor.
