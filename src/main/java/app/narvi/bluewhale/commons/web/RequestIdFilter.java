package app.narvi.bluewhale.commons.web;

import java.io.IOException;
import java.util.UUID;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.XSlf4j;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

@Component
@XSlf4j
public class RequestIdFilter extends OncePerRequestFilter {

  public static final ScopedValue<String> REQUEST_ID = ScopedValue.newInstance();

  @Override
  protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
      throws ServletException, IOException {
    try {
      ScopedValue.callWhere(REQUEST_ID, UUID.randomUUID().toString(), () -> {
        filterChain.doFilter(request, response);
        return null;
      });
    } catch (Exception e) {
      throw new ServletException(e);
    }


  }

}
