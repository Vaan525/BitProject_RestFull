package bit.restfull.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class ResponseVO<T> {

    private int statusCode;
    private String message;
    private T data;

    public ResponseVO(int statusCode, T data) {
        this.statusCode = statusCode;
        this.data = data;
    }
}
