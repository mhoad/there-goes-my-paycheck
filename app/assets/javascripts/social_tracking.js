function google_plus_user (status) {
 if (status) {
  var google_plus_status = 'Logged In';
 } else {
  var google_plus_status = 'Not Logged In';
 };
 ga('set', 'dimension3', google_plus_status);
}

function twitter_user (status) {
 if (status) {
  var twitter_status = 'Logged In';
 } else {
  var twitter_status = 'Not Logged In';
 };
 ga('set', 'dimension2', twitter_status);
}

function google_user (status) {
 if (status) {
  var google_status = 'Logged In';
 } else {
  var google_status = 'Not Logged In';
 };
 ga('set', 'dimension4', google_status);
}