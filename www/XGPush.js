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
    },

    /**
     * ios set badge number method
     */
    setBadge: function (badgeNum, success, error) {
        exec(success, error, 'XGPush', 'setBadge', [badgeNum]);
    }
};

module.exports = XGPush;