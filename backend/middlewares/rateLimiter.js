const rateLimiter = (req, res, next) => {
  // Simple rate limiting - in production, use a proper rate limiting library
  // This is a basic implementation for the assessment
  const clientId = req.ip || req.connection.remoteAddress;
  
  if (!rateLimiter.requests) {
    rateLimiter.requests = new Map();
  }

  const now = Date.now();
  const windowMs = 60000; // 1 minute
  const maxRequests = 100;

  if (!rateLimiter.requests.has(clientId)) {
    rateLimiter.requests.set(clientId, { count: 1, resetTime: now + windowMs });
    return next();
  }

  const clientData = rateLimiter.requests.get(clientId);

  if (now > clientData.resetTime) {
    clientData.count = 1;
    clientData.resetTime = now + windowMs;
    return next();
  }

  if (clientData.count >= maxRequests) {
    return res.status(429).json({
      success: false,
      error: { message: 'Too many requests, please try again later' }
    });
  }

  clientData.count++;
  next();
};

module.exports = { rateLimiter };
