package csns.spring.security;

import org.springframework.security.Authentication;
import org.springframework.security.AuthenticationTrustResolverImpl;
import org.springframework.security.GrantedAuthority;
import org.springframework.security.context.SecurityContextHolder;
import org.springframework.security.userdetails.UserDetails;

public class SecurityUtils {

    public static String getUsername()
    {
        return getUsername( SecurityContextHolder.getContext()
                .getAuthentication() );
    }

    public static String getUsername( Authentication auth )
    {
        return auth.getPrincipal() instanceof UserDetails ? ((UserDetails) auth
                .getPrincipal()).getUsername() : auth.getPrincipal().toString();
    }

    public static boolean isUserInRole( String roleName )
    {
        Authentication auth = SecurityContextHolder.getContext()
                .getAuthentication();

        if( !(auth.getPrincipal() instanceof UserDetails) ) return false;

        GrantedAuthority grantedAuthorities[] = auth.getAuthorities();
        for( int i = 0; i < grantedAuthorities.length; ++i )
            if( grantedAuthorities[i].getAuthority().equals( roleName ) )
                return true;

        return false;

    }

    public static boolean isAnonymousUser()
    {
        return (new AuthenticationTrustResolverImpl())
                .isAnonymous( SecurityContextHolder.getContext()
                        .getAuthentication() );
    }

    public static boolean isAdministrator()
    {
        return isUserInRole( "ROLE_ADMIN" );
    }

}
