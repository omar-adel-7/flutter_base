const String localDataBaseFailure = 'LocalDataBase Failure';
const String unexpectedError = 'Unexpected Error';

String getErrorMessage(bool isLocal) {
  if(isLocal){
    return localDataBaseFailure;
  }
  else{
    return unexpectedError;
  }
}