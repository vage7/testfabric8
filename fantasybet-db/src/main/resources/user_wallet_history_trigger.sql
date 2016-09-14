DELIMITER ///
CREATE TRIGGER history_wallet_upt_trg AFTER UPDATE ON user_wallets
    FOR EACH ROW
    BEGIN  
            INSERT INTO user_wallet_history(id, user_id, wallet_id, currency, date_created, amount) 
            VALUES( unhex(REPLACE(UUID(), '-', '')), NEW.user_id, NEW.id, NEW.currency, NEW.date_updated, NEW.amount);
    END;
///
DELIMITER ;

GRANT TRIGGER ON *.* TO 'b4tb'@'%' IDENTIFIED BY 'addsd';