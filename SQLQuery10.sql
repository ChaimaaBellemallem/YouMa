USE [YouMa]
GO
/****** Object:  StoredProcedure [dbo].[PS_ACL_Exemple]    Script Date: 10/07/2019 15:34:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- ACL : ACCESS CONTROL TABLE
-- STD : STANDARE TABLE
-- =============================================
 --DECLARE @Result Int, @Msg VARCHAR(500);
 --EXEC @Result = [dbo].[PS_ACL_Exemple] 'TEST', @Msg OUTPUT
 --SELECT @Result, @Msg
-- =============================================

ALTER PROCEDURE [dbo].[PS_ACL_Exemple](	
													@nom_	 		VARCHAR(100),
													@prenom_        VARCHAR(100),
													@email_         VARCHAR(255),
													@login_         VARCHAR(100),
													@password_       VARCHAR(255),
                                                    @salt_           VARCHAR(255),
													@actif_				VARCHAR(5)


AS
BEGIN
	SET NOCOUNT ON
	SET IMPLICIT_TRANSACTIONS OFF
  
-- ======================================================================================
-- START : DECLARATION DES VARIABLES	   								                |	
-- ======================================================================================

Declare  	@_CommitVar		Int, 
			@_Msg			Varchar(500)
		    -- Variables Traitement
Declare     @_ReturnValue		 Int
-- ======================================================================================
-- FIN   : DECLARATION DES VARIABLES	   								                |	
-- ======================================================================================

-- ======================================================================================
-- START : Initialisation des variables								                    |	
-- ======================================================================================

			set @_CommitVar		= 0
			set @_Msg			= ''
			set @_ReturnValue	= 0
-- ======================================================================================
-- FIN   : Initialisation des variables								                    |	
-- ======================================================================================

-- ======================================================================================
-- START : TRANSACTION NAME : PS_ACL_Exemple											|	
-- ======================================================================================

  if ( @@trancount = 0  ) begin
    set @_CommitVar = 1
    begin transaction PS_ACL_Exemple
  end

	----------------------------------------
	--	START : OPERATION					|	
    ----------------------------------------
	
	Print 'Insert CMD : ' + @Param1_
	SELECT @_ReturnValue = 1
	-- PSW  = lower(CONVERT(VARCHAR(1000), HASHBYTES('SHA2_512',lower(concat(CONVERT(VARCHAR(1000), HASHBYTES('SHA2_512','123'),2), CONVERT(VARCHAR(1000), HASHBYTES('SHA2_512',upper(Login)),2)))),2)),
	-- SALT = CONVERT(VARCHAR(1000), HASHBYTES('SHA2_512',upper(Login)),2),
	--If ( @@error <> 0 ) Begin
	--	set @_Msg = 'Désolé, Problème pendant la création du lien !'
	--	goto errTransaction	         
	--End
	--select @_ReturnValue = scope_identity()

	----------------------------------------
	--	END : OPERATION						|	
    ----------------------------------------

	IF ( @_CommitVar = 1 ) BEGIN 
    
		COMMIT TRANSACTION PS_ACL_Exemple 
    
	END

	SET @Msg_ = 'Succès.'
	RETURN @_ReturnValue
  
-- ======================================================================================
-- END   : TRANSACTION NAME : PS_ACL_Exemple										    |	
-- ======================================================================================

  
-- ======================================================================================
-- START : TRANSACTION errTransaction BLOCK                                             |	
-- ======================================================================================

  
  errTransaction:
	  SET @Msg_ = 'PS_ACL_Exemple >>> ' + @_Msg
  
	  IF ( @_COMMITVAR = 1 ) BEGIN
		  ROLLBACK TRANSACTION
	  END
  
  RETURN 0
	
-- ======================================================================================
-- END : TRANSACTION errTransaction BLOCK                                               |	
-- ======================================================================================
	
END