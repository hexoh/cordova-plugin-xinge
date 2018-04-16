var exec = require('cordova/exec');

var XGPush = {
    /**
     * Registered Account
     */
    registerAccount: function (account, success, error) {
        exec(success, error, 'XGPush', 'registerAccount', [account]);
    },

    /**
     * Unregistered Account
     */
    unregisterAccount: function (account, success, error) {
        exec(success, error, 'XGPush', 'unregisterAccount', [account]);
    }
};

module.exports = XGPush;