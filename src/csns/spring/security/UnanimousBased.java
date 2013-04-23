package csns.spring.security;

import org.springframework.security.AccessDeniedException;
import org.springframework.security.Authentication;
import org.springframework.security.ConfigAttributeDefinition;
import org.springframework.security.vote.AbstractAccessDecisionManager;
import org.springframework.security.vote.AccessDecisionVoter;

/**
 * This is pretty much the same as
 * <code>org.springframework.security.vote.UnanimousBased</code> except that the
 * entire list of <code>ConfigAttributeDefinition</code> is passed to each
 * decision voter instead of passing each attribute one by one (which breaks the
 * semantic consistency with other decision managers and doesn't make sense).
 */
public class UnanimousBased extends AbstractAccessDecisionManager {

    public void decide( Authentication authentication, Object object,
        ConfigAttributeDefinition config ) throws AccessDeniedException
    {
        int grant = 0;

        for( Object voter : getDecisionVoters() )
        {
            int result = ((AccessDecisionVoter) voter).vote( authentication,
                object, config );

            if( result == AccessDecisionVoter.ACCESS_GRANTED ) ++grant;
            if( result == AccessDecisionVoter.ACCESS_DENIED )
                throw new AccessDeniedException( messages.getMessage(
                    "AbstractAccessDecisionManager.accessDenied",
                    "Access is denied" ) );
        }

        if( grant == 0 ) checkAllowIfAllAbstainDecisions();
    }

}
