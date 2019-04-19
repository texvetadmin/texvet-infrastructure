// https://docs.aws.amazon.com/cognito/latest/developerguide/cognito-user-identity-pools-working-with-aws-lambda-triggers.html

export function handler(event, context, callback) {
  switch (event.triggerSource) {
    case 'TokenGeneration_Authentication':
      _tokenGeneration(event);
      break;
  }

  // Return to Amazon Cognito
  callback(null, event);

  
  // Pre token generation
  // https://docs.aws.amazon.com/cognito/latest/developerguide/user-pool-lambda-pre-token-generation.html
  function _tokenGeneration(event) {
    event.response = {
      'claimsOverrideDetails': {
        'claimsToAddOrOverride': {
          // 'feature_a': 'true' // Put whatever is relevant to the application 
        }
      }
    };
  }
}
