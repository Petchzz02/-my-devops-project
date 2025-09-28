const request = require('supertest');
const app = require('../src/app');

describe('DevOps Practice Project API', () => {
  describe('GET /', () => {
    it('should return welcome message', async () => {
      const response = await request(app).get('/');
      expect(response.status).toBe(200);
      expect(response.body.message).toContain('Welcome to My DevOps Practice Project');
      expect(response.body.version).toBe('1.0.0');
      expect(response.body.timestamp).toBeDefined();
    });
  });

  describe('GET /health', () => {
    it('should return health status', async () => {
      const response = await request(app).get('/health');
      expect(response.status).toBe(200);
      expect(response.body.status).toBe('healthy');
      expect(response.body.uptime).toBeDefined();
      expect(response.body.timestamp).toBeDefined();
    });
  });

  describe('GET /info', () => {
    it('should return project information', async () => {
      const response = await request(app).get('/info');
      expect(response.status).toBe(200);
      expect(response.body.project).toBe('My DevOps Practice Project');
      expect(response.body.technologies).toContain('Node.js');
      expect(response.body.technologies).toContain('Docker');
    });
  });

  describe('GET /nonexistent', () => {
    it('should return 404 for unknown routes', async () => {
      const response = await request(app).get('/nonexistent');
      expect(response.status).toBe(404);
      expect(response.body.error).toBe('Route not found');
    });
  });
});