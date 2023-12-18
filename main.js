exports.handler = async (event) => {
    console.log('Hola desde AWS Lambda con Node');
    return {
      statusCode: 200,
      body: JSON.stringify('¡Hola desde AWS Lambda con Node.js!'),
    };
  };
